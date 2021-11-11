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
  const deleteAccount = () => {
  

  };
  
  function DeleteAccount() {
    const classes = useStyles();
  
    // useState.
    const [deleteConfirmation, setDeleteConfirmation] = useState(false);
  
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
                DELETE ACCOUNT
              </Typography>
              <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={deleteAccount}>
              <Button
                type="submit"
                variant="outlined"
                color="secondary"
                fullWidth
                style={{ marginTop: 16 }}
              >
                Delete
              </Button>
            </form>
            </Paper>
            {deleteConfirmation ? (
            <Alert severity="warning" style={{ marginTop: 16 }}>
              TODO: Implement Alert Dailog
            </Alert>
          ) : null}
          </Box>
        </Box>
      </ThemeProvider>
    );
  }
  
  export default DeleteAccount;
  