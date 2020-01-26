import React from 'react';
import AppBar from '@material-ui/core/AppBar/AppBar';
import Toolbar from '@material-ui/core/Toolbar/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import Typography from '@material-ui/core/Typography';
import InputBase from '@material-ui/core/InputBase';
import styles from './Navbar.jss';
import SearchIcon from '@material-ui/icons/Search';
import { DispatchProp, connect } from 'react-redux';
import { actionToggleSideMenu } from '../../actions/Menus';
import { IAction } from '../../types/actions';


const mapStateToProps = (state: any) => ({ });

type Props =  ReturnType<typeof  mapStateToProps> 
& DispatchProp<IAction>

const NavBar: React.FC<Props> = (props: Props ) => {
    const classes = styles()
    const {dispatch} =props;

    const onHumbergerClick = () => {
        dispatch(actionToggleSideMenu())
    }

    return (
        <AppBar position="static">
            <Toolbar>
                <IconButton edge="start"
                    className={classes.menuButton}
                    color="inherit"
                    aria-label="menu"
                    onClick={onHumbergerClick}
                >
                    <MenuIcon />
                </IconButton>
                <Typography className={classes.title}
                    variant="h6"
                    noWrap
                >
                    Novel Reader
                </Typography>
                <div className={classes.search}>
                    <div className={classes.searchIcon}>
                        <SearchIcon />
                    </div>
                    <InputBase
                        placeholder="Search..."
                        classes={{
                            root: classes.inputRoot,
                            input: classes.inputInput,
                        }}
                        inputProps={{ 'aria-label': 'search' }}
                    />
                    <div className={classes.grow} />

                </div>
            </Toolbar>
        </AppBar>
    )
}

export default connect()(NavBar)