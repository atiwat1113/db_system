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
const updateSavedAddress = (e) => {
  e.preventDefault();
};

function UpdateAddress() {
  const classes = useStyles();

  // useState with variables.
  const [locationID, setLocationID] = useState("");
  const [newName, setNewName] = useState("");

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
            <Typography variant="h5">UPDATE SAVED ADDRESS</Typography>
            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={updateSavedAddress}>
              <TextField
                onChange={(e) => setLocationID(e.target.value)}
                className={classes.field}
                label="Location ID"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setNewName(e.target.value)}
                className={classes.field}
                label="New name to update"
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

export default UpdateAddress;
