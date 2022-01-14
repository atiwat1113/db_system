// Import things.
import {
  makeStyles,
  Button,
  Paper,
  Divider,
  Box,
  Typography,
  createTheme,
  ThemeProvider,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  Collapse,
  IconButton,
} from "@material-ui/core";
import { Alert } from "@mui/material";
import { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles/App.css";
import Navbar from "../components/Navbar";
import axios from "axios";
import CloseIcon from "@mui/icons-material/Close";

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

function DeleteAccount() {
  document.title = "DELETE Account";
  
  const classes = useStyles();

  // useState.
  const [deleteConfirmation, setDeleteConfirmation] = useState(false);
  const [querySuccess, setQuerySuccess] = useState(false);

  //TODO: Handle Close Modal function.
  const handleOpen = (e) => {
    e.preventDefault();
    setDeleteConfirmation(true);
  };
  const handleClose = (e) => {
    e.preventDefault();
    setDeleteConfirmation(false);
  };

  //TODO: Implement HTTP Method
  async function deleteAccount(e) {
    e.preventDefault();
    setDeleteConfirmation(false);

    try {
      const return_status = await axios
        .delete("/customers")
        .then((res) => res.status);
      console.log(return_status);

      if (return_status === 200) {
        setQuerySuccess(true);
      }
    } catch (err) {
      console.log(err);
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
            <Typography variant="h5">DELETE ACCOUNT</Typography>
            <Divider
              style={{ background: "black", marginTop: 16 }}
              variant="fullWidth"
            />
            <form noValidate autoComplete="off" onSubmit={handleOpen}>
              <Collapse
                style={{
                  marginTop: 16,
                  marginBottom: 16,
                }}
                in={querySuccess}
              >
                <Alert
                  action={
                    <IconButton
                      aria-label="close"
                      size="small"
                      onClick={() => {
                        setQuerySuccess(false);
                      }}
                    >
                      <CloseIcon fontSize="inherit" />
                    </IconButton>
                  }
                >
                  Success!
                </Alert>
              </Collapse>

              <Button
                type="submit"
                variant="outlined"
                color="secondary"
                fullWidth
              >
                Delete
              </Button>
            </form>
          </Paper>
        </Box>
      </Box>

      <Dialog
        disableBackdropClick
        open={deleteConfirmation}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">
          {"Are you sure that you want to delete your account?"}
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            By agreeing to delete your account, your account will be deleted and
            can't be retrieved.
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button color="secondary" onClick={handleClose}>
            Disagree
          </Button>
          <Button onClick={deleteAccount} autoFocus>
            Agree
          </Button>
        </DialogActions>
      </Dialog>
    </ThemeProvider>
  );
}

export default DeleteAccount;
