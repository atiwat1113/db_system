// Import things.
import {
  TextField,
  makeStyles,
  Button,
  Paper,
  Divider,
  Box,
  Typography,
  createTheme,
  ThemeProvider,
} from "@material-ui/core";
import { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles/App.css";
import Navbar from "../components/Navbar";
import axios from "axios";

const useStyles = makeStyles((theme) => ({
  // Handle all TextField style.
  field: {
    marginTop: 10,
    marginBottom: 15,
    display: "block",
  },
  toolbar: theme.mixins.toolbar,
}));

const theme = createTheme({
  typography: {
    fontFamily: ["manrope"].join(","),
  },
});

function MainApp() {
  const classes = useStyles();

  // useState with variables.
  const [cardNum, setCardNum] = useState("");
  const [holderName, setHolderName] = useState("");
  const [expireDate, setExpireDate] = useState("");

  //Test Function
  const console_check = () => {
    console.log("Pass");
  };

  //TODO: INSERT credit card.
  async function insertCreditCard(e) {
    e.preventDefault();

    console.log(axios.defaults.withCredentials)

    if (cardNum && holderName && expireDate) {
      const input_body = JSON.stringify({
        card_number: cardNum,
        card_holder_name: holderName,
        expire_date: expireDate,
      });
      try {
        const return_status = await axios
          .post("/customers/cards", input_body, {
            headers: {
              // Overwrite Axios's automatically set Content-Type
              "Content-Type": "application/json",
            },
          })
          .then((res) => res.status);
        console.log(return_status);
      } catch (err) {
        console.log(err);
      }
    }
  }

  return (
    //TODO: Group Components together + Create Style class.
    // Column box arrangement. Each row contains a "row" box with a form (paper) inside.
    <ThemeProvider theme={theme}>
      <Box sx={{ display: "flex", flexDirection: "column" }}>
        <Navbar></Navbar>

        <div className={classes.toolbar}></div>

        <Box sx={{ display: "flex", alignItems: "flex-start" }}>
          <Paper
            style={{
              margin: 16,
              padding: 32,
            }}
            elevation={3}
          >
            <Typography variant="h5">INSERT CREDIT CARD</Typography>

            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={insertCreditCard}>
              <TextField
                onChange={(e) => setCardNum(e.target.value)}
                className={classes.field}
                label="Credit Card Number"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setHolderName(e.target.value)}
                className={classes.field}
                label="Card Holder Name"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setExpireDate(e.target.value)}
                className={classes.field}
                label="Expire Date"
                required
                fullWidth
              />

              <Button
                type="submit"
                variant="outlined"
                color="primary"
                fullWidth
                style={{ marginTop: 10 }}
              >
                Submit
              </Button>
            </form>
          </Paper>
        </Box>
      </Box>
    </ThemeProvider>
  );
}

export default MainApp;
