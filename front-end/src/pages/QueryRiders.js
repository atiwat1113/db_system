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
  Table,
  TableContainer,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
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
  const [returnData, setReturnData] = useState([]);

  function createData(name, calories, fat, carbs, protein) {
    return { name, calories, fat, carbs, protein };
  }

  const rows = [
    createData("Frozen yoghurt", 159, 6.0, 24, 4.0),
    createData("Ice cream sandwich", 237, 9.0, 37, 4.3),
    createData("Eclair", 262, 16.0, 24, 6.0),
    createData("Cupcake", 305, 3.7, 67, 4.3),
    createData("Gingerbread", 356, 16.0, 49, 3.9),
  ];

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
          .then((res) => res.data[0]);

        //TODO: Alter some return data.
        return_data.map((row) => {
          for (const [key, value] of Object.entries(row)) {
            if (key === "is_available"){
              if (value === 1){
                row[key] = 'Available';
              } else {
                row[key] = 'Unavailable'
              }
            }

            if (key === "rating"){
              if (!value){
                row[key] = 'TBD'
              }
            }
          }
        })

        //TODO: Set ReturnData to Table
        setReturnData(return_data);

        

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
              minWidth: 400,
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

          <TableContainer
            component={Paper}
            style={{
              margin: 16,
              minWidth: 400,
            }}
          >
            <Table
              sx={{ minWidth: 650 }}
              size="small"
              aria-label="a dense table"
            >
              <TableHead>
                <TableRow>
                  <TableCell>First Name</TableCell>
                  <TableCell>Last Name</TableCell>
                  <TableCell>Ref Number</TableCell>
                  <TableCell>Is Available</TableCell>
                  <TableCell>Rating</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {returnData.map((row) => (
                  <TableRow
                    key={row.name}
                    sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                  >
                    <TableCell key={0} component="th" scope="row">
                      {row.first_name}
                    </TableCell>
                    <TableCell>{row.last_name}</TableCell>
                    <TableCell>{row.ref_no}</TableCell>
                    <TableCell>{row.is_available}</TableCell>
                    <TableCell>{row.rating}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Box>
      </Box>
    </ThemeProvider>
  );
}

export default QueryRiders;
