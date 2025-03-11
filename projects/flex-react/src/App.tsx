import './App.css'

function App() {

  return (
    <div style={{display: 'flex', flexDirection: 'column', width: '100%', border: '2px dashed pink'}}>
      <div style={{display: 'flex', width: '100%', border: '2px solid blue'}}>
        <div style={{height: '100px', flex: 'auto', background: 'red'}}></div>
        <div style={{height: '100px', flex: 'none', background: 'green'}}></div>
      </div>
      <div style={{display: 'flex', width: '100%', border: '2px solid blue'}}>
        <div style={{height: '100px', flex: 1, background: 'red'}}></div>
        <div style={{height: '100px', flex: 1, background: 'green'}}></div>
      </div>
    </div>
  )
}

export default App
