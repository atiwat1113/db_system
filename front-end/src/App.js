import { Button, TextField, Card } from "@material-ui/core";
// import logo from './logo.svg';
import "./App.css";

function App() {
  return (
    <div className="App">
      <Button color="primary" variant="contained">
        Click Me
      </Button>
      Learn React
      <Card>
        <TextField
          id="outlined-basic"
          label="Outlined"
          variant="outlined"
        ></TextField>
      </Card>
      <div class="d-flex flex-row bd-highlight mb-3">
        <div class="p-2 bd-highlight">Flex item 1</div>
        <div class="p-2 bd-highlight">Flex item 2</div>
        <div class="p-2 bd-highlight">Flex item 3</div>
      </div>
    </div>
  );
}

export default App;
