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
  Select,
  MenuItem,
} from "@material-ui/core";
import { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles/App.css";
import Navbar from "../components/Navbar";
import axios from "axios";
import DateAdapter from "@mui/lab/AdapterMoment";
import DateTimePicker from "@mui/lab/DateTimePicker";
import LocalizationProvider from "@mui/lab/LocalizationProvider";
import moment from 'moment';

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

function BookARide() {
  const classes = useStyles();

  // useState with variables.
  const [startLatitude, setStartLatitude] = useState(0.0);
  const [startLongitude, setStartLongitude] = useState(0.0);
  const [stopLatitude, setStopLatitude] = useState(0.0);
  const [stopLongitude, setstopLongitude] = useState(0.0);
  const [distance, setDistance] = useState(0.0);
  const [dateTime, setDateTime] = useState(new Date());
  const [payment_method, setPayment_Method] = useState("cash");

  //Test Function
  const console_check = () => {
    console.log("Pass");
  };

  //TODO: INSERT credit card.
  async function bookRide(e) {
    e.preventDefault();

    if(startLatitude && startLongitude && stopLatitude && stopLongitude && distance && dateTime && payment_method){
      const input_body = JSON.stringify({
        start_latitude: parseFloat(startLatitude),
        start_longitude: parseFloat(startLongitude),
        stop_latitude: parseFloat(stopLatitude),
        stop_longitude: parseFloat(stopLongitude),
        distance: parseFloat(distance),
        start_time: moment(dateTime).format('YYYY-MM-DD HH:mm:ss'),
        payment_method: payment_method,
      });
      
      try {
        const return_status = await axios
          .post("/customers/ride-transaction", input_body, {
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
            <Typography variant="h5">BOOK A RIDE (INSERT)</Typography>

            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={bookRide}>
              <LocalizationProvider dateAdapter={DateAdapter}>
                <DateTimePicker
                  label="Date Time picker"
                  value={dateTime}
                  onChange={(e) => setDateTime(e)}
                  renderInput={(dateTime) => (
                    <TextField
                      style={{ marginTop: 16 }}
                      {...dateTime}
                      fullWidth
                    />
                  )}
                />
              </LocalizationProvider>
              <TextField
                onChange={(e) => setStartLatitude(e.target.value)}
                className={classes.field}
                label="Start Latitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setStartLongitude(e.target.value)}
                className={classes.field}
                label="Start Longitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setStopLatitude(e.target.value)}
                className={classes.field}
                label="Stop Latitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setstopLongitude(e.target.value)}
                className={classes.field}
                label="Stop Longitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setDistance(e.target.value)}
                className={classes.field}
                label="Distance"
                required
                fullWidth
              />
              <TextField
                fullWidth
                className={classes.field}
                value={payment_method}
                onChange={(e) => setPayment_Method(e.target.value)}
                select // tell TextField to render select
                label="Payment Method"
              >
                <MenuItem key={1} value="cash">
                  Cash
                </MenuItem>
                <MenuItem key={2} value="bank_transfer">
                  Bank Transfer
                </MenuItem>
                <MenuItem key={3} value="credit_card">
                  Credit Card
                </MenuItem>
              </TextField>

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

export default BookARide;
