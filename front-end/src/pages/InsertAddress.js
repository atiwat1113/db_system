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

//TODO: Implement HTTP Method
const insertNewAddress = (e) => {

  e.preventDefault();
};

function InsertAddress() {
  const classes = useStyles();

  // useState with variables.
  const [latitude, setLatitude] = useState("");
  const [longitude, setLongitude] = useState("");
  const [addressName, setAddressName] = useState("");

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
            <Typography variant="h5">
              INSERT NEW ADDRESS (NOSQL)
            </Typography>
            
            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={insertNewAddress}>
              <TextField
                onChange={(e) => setLatitude(e.target.value)}
                className={classes.field}
                label="Latitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setLongitude(e.target.value)}
                className={classes.field}
                label="Longitude"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setAddressName(e.target.value)}
                className={classes.field}
                label="Address Name"
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

export default InsertAddress;
