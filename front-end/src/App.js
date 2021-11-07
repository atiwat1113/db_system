// Import things.
import {
  TextField,
  makeStyles,
  Button,
  Paper,
  Divider,
  Box,
} from "@material-ui/core";
import { Alert } from "@mui/material";
import { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";

const useStyles = makeStyles({
  // Handle all TextField style.
  field: {
    marginTop: 10,
    marginBottom: 15,
    display: "block",
  },
});

function App() {
  const classes = useStyles();

  // useState with variables.
  const [cardNum, setCardNum] = useState("");
  const [holderName, setHolderName] = useState("");
  const [expireDate, setExpireDate] = useState("");
  const [locationID, setLocationID] = useState("");
  const [newName, setNewName] = useState("");
  const [latitude, setLatitude] = useState("");
  const [longitude, setLongitude] = useState("");
  const [addressName, setAddressName] = useState("");

  // useState with an actual state.
  const [deleteConfirmation, setDeleteConfirmation] = useState(false);

  //TODO: INSERT credit card.
  const insertCreditCard = (e) => {
    e.preventDefault();
  };

  //TODO: UPDATE saved address.
  const updateSavedAddress = (e) => {
    e.preventDefault();
  };

  //TODO: INSERT new adress.
  const insertNewAddress = (e) => {
    e.preventDefault();
  };

  //TODO: DELETE account.
  const deleteAccount = (e) => {
    setDeleteConfirmation((prev) => !prev);
    console.log(deleteConfirmation);
    e.preventDefault();
  };

  return (
    // Column box arrangement. Each row contains a "row" box with a form (paper) inside.
    <Box sx={{ display: "flex", flexDirection: "column" }}>
      <Box sx={{ display: "flex", alignItems: "flex-start" }}>
        <Paper
          style={{
            margin: 16,
            padding: 32,
          }}
        >
          <h3>INSERT CREDIT CARD</h3>
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
      <Box sx={{ display: "flex", alignItems: "flex-start" }}>
        <Paper
          style={{
            margin: 16,
            padding: 32,
          }}
        >
          <h3>UPDATE SAVED ADDRESS</h3>
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
        <Paper
          style={{
            margin: 16,
            padding: 32,
          }}
        >
          <h3>INSERT NEW ADDRESS (NOSQL)</h3>
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
      <Box sx={{ display: "flex", alignItems: "flex-start" }}>
        <Paper
          style={{
            margin: 16,
            padding: 32,
          }}
        >
          <h3>DELETE ACCOUNT</h3>
          <Divider
            style={{ background: "black", marginTop: 16 }}
            variant="fullWidth"
          />
          <form noValidate autoComplete="off" onSubmit={deleteAccount}>
            <Button
              type="submit"
              variant="outlined"
              color="primary"
              fullWidth
              style={{ marginTop: 16 }}
            >
              Submit
            </Button>
          </form>
        </Paper>
        {deleteConfirmation ? (
          <Alert severity="warning" style={{marginTop: 16}}>
            TODO: Implement Alert Dailog
          </Alert>
        ) : null}
      </Box>
    </Box>
  );
}

export default App;
