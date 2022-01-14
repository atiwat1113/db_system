// Import things.
import {
  makeStyles,
  Box,
  Typography,
} from "@material-ui/core";
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

function MainPage() {
  const classes = useStyles();
  document.title = "Happy Birthday Aj.Ann <3";

  return (
    <Box sx={{ display: "flex", flexDirection: "column"}}>
      <Navbar></Navbar>
      <div className={classes.toolbar}></div>
      <Box marginLeft={20+'px'}>
      <Typography variant="h4">
          Please Select one operation above you want to perform.
      </Typography>
      <Typography variant="h4" style={{ marginTop: 16 }}>
          Happy (belated, if on Thursday) Birthday Aj. Ann &lt;3
      </Typography>
      </Box>
    </Box>
  );
}

export default MainPage;
