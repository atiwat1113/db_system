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
    fontFamily: ["Manrope"].join(","),
  },
});

function QueryRiders() {
  const classes = useStyles();

  // useState with variables.
  const [stationName, setStationName] = useState("");

  //TODO: Implement HTTP Method
  async function queryRiders(e) {
    e.preventDefault();

    if (stationName) {
      try {
        const return_data = await axios
          .get("/riders/info", {
            params: {
              stationName: stationName,
            },
          })
          .then((res) => res.data);
        console.log(return_data);
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
            <Typography variant="h5">QUERY RIDERS FROM STATION</Typography>
            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={queryRiders}>
              <TextField
                onChange={(e) => setStationName(e.target.value)}
                className={classes.field}
                label="Station name"
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

export default QueryRiders;
