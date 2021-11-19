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
import { Alert } from "@mui/material";
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
    fontFamily: ["Manrope"].join(","),
  },
});

function UpdateStation() {
  const classes = useStyles();

  // useState with variables.
  const [stationID, setStationID] = useState("");

  //TODO: Implement HTTP Method
  async function updateStationID(e) {
    e.preventDefault();

    if (stationID) {
      const input_body = JSON.stringify({
        station_ID: stationID,
      });
      try {
        const return_status = await axios
          .patch("/riders/station", input_body, {
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
          >
            <Typography variant="h5">UPDATE STATION</Typography>
            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={updateStationID}>
              <TextField
                onChange={(e) => setStationID(e.target.value)}
                className={classes.field}
                label="Station ID"
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

export default UpdateStation;
