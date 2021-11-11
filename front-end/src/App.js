import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import InsertCard from "./pages/InsertCard";
import InsertAddress from "./pages/InsertAddress";
import MainPage from "./pages/MainPage"
import DeleteAccount from "./pages/DeleteAccount"
import { createTheme, makeStyles, ThemeProvider } from "@material-ui/core";
import './index.css';
import UpdateAddress from "./pages/UpdateAddress";
import QueryRiders from "./pages/QueryRiders";

const theme = createTheme({
    typography: {
      fontFamily: [
        "manrope"
      ].join(","),
    },
  });



function App() {
  return (
    <div>
      <ThemeProvider theme={theme}>
        <Router>
            <Routes>
            <Route exact path="/" element={<MainPage/>}/>
            <Route exact path="/insert_card" element={<InsertCard/>}/>
            <Route exact path="/insert_add" element={<InsertAddress/>}/>
            <Route exact path="/update_add" element={<UpdateAddress/>}/>
            <Route exact path="/del_acc" element={<DeleteAccount/>}/>
            <Route exact path="/query_riders" element={<QueryRiders/>}/>
            </Routes>
        </Router>
      </ThemeProvider>
    </div>
  );
}

export default App;
