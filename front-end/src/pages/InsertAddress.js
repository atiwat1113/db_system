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
  Collapse,
  IconButton,
} from "@material-ui/core";
import { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles/App.css";
import Navbar from "../components/Navbar";
import axios from "axios";
import { Alert } from "@mui/material";
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

function InsertAddress() {
  const classes = useStyles();

  // useState with variables.
  const [latitude, setLatitude] = useState("");
  const [longitude, setLongitude] = useState("");
  const [subDistrict, setSubDistrict] = useState("");
  const [district, setDistrict] = useState("");
  const [province, setProvince] = useState("");
  const [postalCode, setPostalCode] = useState("");
  const [addressName, setAddressName] = useState("");
  const [querySuccess, setQuerySuccess] = useState(false);

  //TODO: Implement HTTP Method
  async function insertNewAddress(e) {
    e.preventDefault();

    const input_body = JSON.stringify({
      lat: latitude,
      long: longitude,
      sub_district: subDistrict,
      district: district,
      province: province,
      postal_code: postalCode,
      name: addressName,
    });

    console.log(input_body);

    try {
      const return_status = await axios
        .post("/mongo", input_body, {
          headers: {
            // Overwrite Axios's automatically set Content-Type
            "Content-Type": "application/json",
          },
        })
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
            <Typography variant="h5">
              INSERT NEW SAVED ADDRESS (NOSQL)
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
                onChange={(e) => setSubDistrict(e.target.value)}
                className={classes.field}
                label="Subdistrict"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setDistrict(e.target.value)}
                className={classes.field}
                label="District"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setProvince(e.target.value)}
                className={classes.field}
                label="Province"
                required
                fullWidth
              />
              <TextField
                onChange={(e) => setPostalCode(e.target.value)}
                className={classes.field}
                label="Postal Code"
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

              <Collapse in={querySuccess}>
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
