const test = require('node:test');
const assert = require('node:assert').strict;

test('synchronous passing test', () => {
    // This test passes because it does not throw an exception.
    assert.strictEqual(1, 1);
});

test('Mapに値を一括で追加する', () => {
    const map = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    assert.equal(map.get('key1'), 'value1');
    assert.equal(map.get('key2'), 'value2');
})

test('既存のMapに値を一括で追加する(重複なし)', () => {
    const map1 = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    const map2 = new Map(
        [
            ['key3', 'value3'],
            ['key4', 'value4']
        ]
    );
    const map = new Map([...map1, ...map2]);
    assert.equal(map.get('key1'), 'value1');
    assert.equal(map.get('key2'), 'value2');
    assert.equal(map.get('key3'), 'value3');
    assert.equal(map.get('key4'), 'value4');
})

test('既存のMapに値を一括で追加する(重複あり)', () => {
    const map1 = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    const map2 = new Map(
        [
            ['key2', 'value3'],
            ['key4', 'value4']
        ]
    );
    const map = new Map([...map1, ...map2]);
    assert.equal(map.get('key1'), 'value1');
    assert.equal(map.get('key2'), 'value3');
    assert.equal(map.get('key4'), 'value4');
    assert.equal(map.size, 3);
})

test('Mapに存在しないキーを指定して値を取得する', () => {
    const map = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    assert.equal(map.get('key3'), undefined);
})

test('Mapに存在しないキーを削除する', () => {
    const map = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    assert.equal(map.delete('key3'), false);
})

test('Mapに存在するキーを削除する', () => {
    const map = new Map(
        [
            ['key1', 'value1'],
            ['key2', 'value2']
        ]
    );
    assert.equal(map.delete('key1'), true);
    assert.equal(map.get('key1'), undefined);
})

test('Mapへメソッドチェインで値を追加する', () => {
    const map = new Map()
        .set('key1', 'value1')
        .set('key2', 'value2');
    assert.equal(map.get('key1'), 'value1');
    assert.equal(map.get('key2'), 'value2');
})