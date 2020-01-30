import { GridList, GridListTile, GridListTileBar, IconButton } from "@material-ui/core";
import { MoreHoriz } from "@material-ui/icons";
import React from 'react';
import { connect, DispatchProp } from 'react-redux';
import { actionToggleSideMenu } from '../../actions/Menus';
import { AppState } from "../../reducers";
import { ShelfStates } from '../../reducers/Shelf.reducer.';
import { IAction } from "../../types/actions";
import NavBar from '../navbar/Navbar';
import { SideMenu } from '../sideMenu/SideMenu';
import styles from './Shelf.jss';

const mapStateToProps = (state: AppState)  => ({
    showSideMenu: state.Shelf.showSideMenu
});

type PropsType = ShelfStates & DispatchProp<IAction>;

const Shelf: React.FC<PropsType> = (props: PropsType) => {
    const classes = styles();
    const { dispatch } = props;

    const toggleSideMenu = () => {
        dispatch(actionToggleSideMenu())
    }

    return (
        <div className={classes.root}>
            <NavBar />
            <GridList cols={3} 
                cellHeight={180}
                spacing={16}
                className={classes.gridList}>
                
                {[1,2,3,4].map(v => (
                    <GridListTile key={v}>
                        <img src="no_img.png" alt="" />
                        <GridListTileBar
                            title="title"
                            subtitle="subtitle"
                            actionIcon={
                                <IconButton className={classes.icon}>
                                    <MoreHoriz />
                                </IconButton>
                            }
                        />
                    </GridListTile>
                ))}
            </GridList>
            <SideMenu open={props.showSideMenu} onClose={toggleSideMenu}  />
        </div>
    )
}

export default connect(mapStateToProps)(Shelf);