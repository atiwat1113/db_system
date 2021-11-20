import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import BookARide from "./pages/BookARide";
import InsertAddress from "./pages/InsertAddress";
import MainPage from "./pages/MainPage";
import DeleteAccount from "./pages/DeleteAccount";
import { createTheme, ThemeProvider } from "@material-ui/core";
import "./index.css";
import UpdateStation from "./pages/UpdateStation";
import QueryRiders from "./pages/QueryRiders";

const theme = createTheme({
  typography: {
    fontFamily: ["manrope"].join(","),
  },
});

function App() {
  return (
    <div>
      <ThemeProvider theme={theme}>
        <Router>
          <Routes>
            <Route exact path="/" element={<MainPage />} />
            <Route exact path="/book_a_ride" element={<BookARide />} />
            <Route exact path="/insert_add" element={<InsertAddress />} />
            <Route exact path="/update_station" element={<UpdateStation />} />
            <Route exact path="/del_acc" element={<DeleteAccount />} />
            <Route exact path="/query_riders" element={<QueryRiders />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </div>
  );
}

export default App;
