import { GridList, GridListTile, GridListTileBar, IconButton } from "@material-ui/core";
import React from 'react';
import { connect } from 'react-redux';
import styles from './Shelf.jss';
import { MoreHoriz } from "@material-ui/icons";
import NavBar from '../navbar/Navbar';


const Shelf: React.FC = (props) => {
    const classes = styles();

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
        </div>
    )
}

export default connect()(Shelf);