require 'rails_helper'

RSpec.describe 'assign_attributesの挙動', type: :model do
  describe 'has_one関連の自動保存の挙動' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }

    context '新しいプロフィールを代入する場合' do
      it 'プロフィールが自動的に保存される' do
        profile = Profile.new(bio: 'テストプロフィール')
        
        expect {
          user.profile = profile
        }.to change { Profile.count }.by(1)
        
        expect(profile.persisted?).to be true
        expect(profile.user_id).to eq(user.id)
      end

      it '既存プロフィールを置換する際に削除される（dependent: :destroy）' do
        existing_profile = user.create_profile!(bio: '元のプロフィール')
        existing_profile_id = existing_profile.id
        new_profile = Profile.new(bio: '新しいプロフィール')
        
        expect {
          user.profile = new_profile
        }.to change { Profile.count }.by(0)
        
        expect(new_profile.persisted?).to be true
        expect(new_profile.bio).to eq('新しいプロフィール')
        expect { Profile.find(existing_profile_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'assign_attributesを使用する場合' do
      it 'assign_attributes実行時には自動保存されない' do
        expect {
          user.assign_attributes(profile_attributes: { bio: 'テストプロフィール' })
        }.not_to change { Profile.count }
        
        expect {
          user.save!
        }.to change { Profile.count }.by(1)
      end

      it 'ネストした属性を通じて既存プロフィールを更新する' do
        existing_profile = user.create_profile!(bio: '元のプロフィール')
        
        user.assign_attributes(profile_attributes: { id: existing_profile.id, bio: '更新されたプロフィール' })
        user.save!
        
        expect(existing_profile.reload.bio).to eq('更新されたプロフィール')
      end

      it '_destroyフラグでプロフィールを削除する' do
        existing_profile = user.create_profile!(bio: '元のプロフィール')
        
        expect {
          user.assign_attributes(profile_attributes: { id: existing_profile.id, _destroy: true })
          user.save!
        }.to change { Profile.count }.by(-1)
      end
    end
  end

  describe 'has_many関連の自動保存の挙動' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }

    context '投稿を直接追加する場合' do
      it 'ユーザーが永続化されている場合は投稿が自動保存される' do
        post = Post.new(title: 'テスト投稿', content: 'テスト内容')
        
        expect {
          user.posts << post
        }.to change { Post.count }.by(1)
        
        expect(post.persisted?).to be true
        expect(post.user_id).to eq(user.id)
      end

      it 'ユーザーが永続化されていない場合は自動保存されない' do
        new_user = User.new(name: '新しいユーザー', email: 'new@example.com')
        post = Post.new(title: 'テスト投稿', content: 'テスト内容')
        
        expect {
          new_user.posts << post
        }.not_to change { Post.count }
        
        expect(post.persisted?).to be false
      end
    end

    context 'post_idsによる代入（置換挙動）' do
      let!(:post1) { user.posts.create!(title: '投稿1', content: '内容1') }
      let!(:post2) { user.posts.create!(title: '投稿2', content: '内容2') }
      let!(:other_post) { Post.create!(title: '他の投稿', content: '他の内容', user: User.create!(name: '他のユーザー', email: 'other@example.com')) }

      it '既存の関連を置換する（dependent: :destroyにより削除）' do
        expect(user.posts.count).to eq(2)
        post2_id = post2.id
        
        user.post_ids = [post1.id, other_post.id]
        
        expect(user.posts.reload.pluck(:id)).to contain_exactly(post1.id, other_post.id)
        expect { Post.find(post2_id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect(other_post.reload.user_id).to eq(user.id)
      end

      it '空配列を代入すると全ての関連投稿が削除される（dependent: :destroy）' do
        post1_id = post1.id
        post2_id = post2.id
        
        user.post_ids = []
        
        expect(user.posts.reload).to be_empty
        expect { Post.find(post1_id) }.to raise_error(ActiveRecord::RecordNotFound)
        expect { Post.find(post2_id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'assign_attributesとネストした属性を使用する場合' do
      it 'posts_attributesを使用すると新しい投稿が追加される（置換ではない）' do
        existing_post = user.posts.create!(title: '既存投稿', content: '既存内容')
        
        user.assign_attributes(posts_attributes: [{ title: '新しい投稿', content: '新しい内容' }])
        user.save!
        
        expect(user.posts.reload.count).to eq(2)
        expect(user.posts.pluck(:title)).to contain_exactly('既存投稿', '新しい投稿')
        expect(existing_post.reload.title).to eq('既存投稿')
      end

      it 'idが提供されると既存投稿が更新される' do
        existing_post = user.posts.create!(title: '元のタイトル', content: '元の内容')
        
        user.assign_attributes(posts_attributes: [
          { id: existing_post.id, title: '更新済み', content: '更新された内容' },
          { title: '新しい投稿', content: '新しい内容' }
        ])
        user.save!
        
        expect(user.posts.reload.count).to eq(2)
        expect(existing_post.reload.title).to eq('更新済み')
      end

      it '_destroyフラグで投稿を削除する' do
        post1 = user.posts.create!(title: '投稿1', content: '内容1')
        post2 = user.posts.create!(title: '投稿2', content: '内容2')
        
        user.assign_attributes(posts_attributes: [
          { id: post1.id, _destroy: true },
          { id: post2.id, title: '更新された投稿2' }
        ])
        user.save!
        
        expect(user.posts.reload.count).to eq(1)
        expect(user.posts.first.title).to eq('更新された投稿2')
        expect { post1.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'ポリモーフィック関連の挙動' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }
    let(:post) { user.posts.create!(title: 'テスト投稿', content: 'テスト内容') }

    context 'ポリモーフィック関連でassign_attributesを使用する場合' do
      it 'ネストした属性を通じて投稿にコメントを作成する' do
        post.assign_attributes(comments_attributes: [
          { content: 'コメント1', user_id: user.id },
          { content: 'コメント2', user_id: user.id }
        ])
        post.save!
        
        expect(post.comments.count).to eq(2)
        expect(post.comments.first.commentable).to eq(post)
        expect(post.comments.first.user).to eq(user)
      end

      it 'ネストした属性を通じてユーザーにコメントを作成する' do
        user.assign_attributes(comments_attributes: [
          { content: 'ユーザーコメント', commentable_type: 'User', commentable_id: user.id }
        ])
        user.save!
        
        expect(user.comments.count).to eq(1)
        expect(Comment.where(commentable: user).count).to eq(1)
      end
    end
  end

  describe 'has_many :through関連の挙動' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }
    let(:post) { user.posts.create!(title: 'テスト投稿', content: 'テスト内容') }
    let!(:tag1) { Tag.create!(name: 'タグ1') }
    let!(:tag2) { Tag.create!(name: 'タグ2') }

    context 'tag_idsによる代入' do
      it '中間レコードを自動的に作成する' do
        expect {
          post.tag_ids = [tag1.id, tag2.id]
        }.to change { PostTag.count }.by(2)
        
        expect(post.tags.reload).to contain_exactly(tag1, tag2)
      end

      it '既存のタグ関連を置換する' do
        post.tags << tag1
        expect(post.tags.count).to eq(1)
        
        post.tag_ids = [tag2.id]
        
        expect(post.tags.reload).to contain_exactly(tag2)
        expect(PostTag.where(post: post, tag: tag1)).to be_empty
      end
    end

    context '中間モデルを通じたネストした属性' do
      it 'post_tags_attributesを通じて中間レコードを作成する' do
        post.assign_attributes(post_tags_attributes: [
          { tag_id: tag1.id },
          { tag_id: tag2.id }
        ])
        post.save!
        
        expect(post.post_tags.count).to eq(2)
        expect(post.tags).to contain_exactly(tag1, tag2)
      end
    end
  end

  describe 'バリデーション失敗時のシナリオ' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }

    before do
      # テスト用にPostモデルにバリデーションを追加
      Post.class_eval do
        validates :title, presence: true
      end
    end

    after do
      # テスト後にバリデーションを削除
      Post.clear_validators!
    end

    it 'バリデーション失敗時に部分的な保存を行わない' do
      expect {
        user.assign_attributes(posts_attributes: [
          { title: '', content: '無効な投稿' },
          { title: '有効な投稿', content: '有効な内容' }
        ])
        user.save
      }.not_to change { Post.count }
      
      expect(user.valid?).to be false
    end

    it 'バリデーション失敗時に全ての変更をロールバックする' do
      existing_post = user.posts.create!(title: '既存投稿', content: '既存内容')
      
      user.assign_attributes(
        name: '更新された名前',
        posts_attributes: [
          { id: existing_post.id, title: '更新された既存投稿' },
          { title: '', content: '無効な新しい投稿' }
        ]
      )
      
      expect(user.save).to be false
      expect(user.reload.name).to eq('テストユーザー')
      expect(existing_post.reload.title).to eq('既存投稿')
    end
  end

  describe '複雑なネストしたシナリオ' do
    let(:user) { User.create!(name: 'テストユーザー', email: 'test@example.com') }

    it '複数の関連を持つ深いネストを処理する' do
      tag = Tag.create!(name: 'テストタグ')
      
      user.assign_attributes(
        profile_attributes: { bio: 'テストプロフィール' },
        posts_attributes: [
          {
            title: 'ネストした関連を持つ投稿',
            content: '内容',
            comments_attributes: [
              { content: 'ネストしたコメント', user_id: user.id }
            ],
            post_tags_attributes: [
              { tag_id: tag.id }
            ]
          }
        ]
      )
      
      expect { user.save! }.to change { Profile.count }.by(1)
                            .and change { Post.count }.by(1)
                            .and change { Comment.count }.by(1)
                            .and change { PostTag.count }.by(1)
      
      post = user.posts.first
      expect(post.comments.count).to eq(1)
      expect(post.tags).to include(tag)
      expect(user.profile.bio).to eq('テストプロフィール')
    end
  end
end