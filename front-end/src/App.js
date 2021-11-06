import {
  TextField,
  makeStyles,
  Button,
  Paper,
  Grid,
  Divider,
} from "@material-ui/core";

import "bootstrap/dist/css/bootstrap.min.css";
import "./App.css";
import { useState } from "react";

const useStyles = makeStyles({
  field: {
    marginTop: 10,
    marginBottom: 15,
    display: "block",
    
  },
});


function App() {
  const classes = useStyles();
  const [cardNum, setCardNum] = useState("");
  const [holderName, setHolderName] = useState("");
  const [expireDate, setExpireDate] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    if (cardNum && holderName && expireDate) {
      console.log(cardNum, holderName, expireDate);
    }
  };

  return (
    <Grid container spacing={2}>
      <Grid item xs={4}>
        <Paper
          style={{
            margin: 16,
            padding: 16
          }}
        >
          <h3>INSERT CREDIT CARD</h3>
          <Divider style={{ background: 'black', marginTop: 16}} variant="fullWidth" />
          <form noValidate autoComplete="off" onSubmit={handleSubmit}>
            <TextField
              key="Confirmation Code"
              onChange={(e) => setCardNum(e.target.value)}
              className={classes.field}
              label="Credit Card Number"
              required
            />
            <TextField
              onChange={(e) => setHolderName(e.target.value)}
              className={classes.field}
              label="Card Holder Name"
              required 
            />
            <TextField
              onChange={(e) => setExpireDate(e.target.value)}
              className={classes.field}
              label="Expire Date"
              required
            />

              <Button type="submit" variant="outlined" color="primary">
                Submit
              </Button>

          </form>
        </Paper>
      </Grid>
    </Grid>
  );
}

export default App;
