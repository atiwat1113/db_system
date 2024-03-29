// Import things.
import {
  Box,
  AppBar,
  Toolbar,
  Typography,
} from "@material-ui/core";
import { Link } from "@mui/material";
import "bootstrap/dist/css/bootstrap.min.css";
import "../styles/App.css";


function NavLink({ link_to, label, underline = "hover", margin = 15 }) {
  return (
    <Link
      href={link_to}
      color="#FFFFFF"
      underline={underline}
      sx={{
        ":hover": {
          color: "white",
        },
        marginLeft: margin + "px",
        marginRight: margin + "px",
      }}
    >
      {label}
    </Link>
  );
}

function Navbar() {
  return (
    //TODO: Group Components together + Create Style class.
    // Column box arrangement. Each row contains a "row" box with a form (paper) inside.
    <AppBar elevation={2}>
      <Toolbar variant="dense">
        <Typography variant="h5">
          <NavLink label="WinWin" link_to="/" underline="none" margin={0} />
        </Typography>
        <Box
          sx={{ display: "flex", alignItems: "flex-start", paddingLeft: 20 }}
        >
          <Typography>
            <NavLink label="Book a Ride (INSERT)" link_to="/book_a_ride" />
            <NavLink label="UPDATE Station" link_to="/update_station" />
            <NavLink label="QUERY Riders" link_to="/query_riders" />
            <NavLink label="DELETE Account" link_to="/del_acc" />
            <NavLink label="INSERT Address (NOSQL)" link_to="/insert_add" />
          </Typography>
        </Box>
      </Toolbar>
    </AppBar>
  );
}

export default Navbar;
