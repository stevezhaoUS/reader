import { BottomNavigation, BottomNavigationAction, Drawer, Grid, IconButton, Slider, List, ListItem } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import { SkipNext, SkipPrevious } from '@material-ui/icons';
import BookRoundedIcon from '@material-ui/icons/BookRounded';
import Brightness7RoundedIcon from '@material-ui/icons/Brightness7Rounded';
import CodeRoundedIcon from '@material-ui/icons/CodeRounded';
import MenuBookRoundedIcon from '@material-ui/icons/MenuBookRounded';
import TranslateRoundedIcon from '@material-ui/icons/TranslateRounded';
import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { AppState } from '../../reducers';
import { Brightness } from './subPanels/Brightness';
import { Read } from './subPanels/Read';
import { Font } from './subPanels/Font';

const useStyles = makeStyles({
    root: {
        width: '100wh'
    },
    progress: {
        flexGrow: 1
    }
})


const Progress = () => (
    <List dense>
        <ListItem>
        <IconButton>
            <SkipPrevious />
        </IconButton>
        <Slider defaultValue={30} />
        <IconButton>
            <SkipNext />
        </IconButton>
        </ListItem>
    </List>
)


const BookMark = () => (
    <div>bookmark</div>
)

export const ControlPanel = () => {
    const show = useSelector((state: AppState) => state.Reader.showControlPanel);
    const dispatch = useDispatch()

    const toggleControlPanel = () => {

    }
    const classes = useStyles();

    const [value, setValue] = React.useState('progress')

    const handleChange = (_: any, newValue: React.SetStateAction<string>) => {
        setValue(newValue)
    }

    const subPanels: { [index: string]: () => JSX.Element } = {
        progress: Progress,
        brightness: Brightness,
        font: Font,
        read: Read,
        bookMark: BookMark
    }

    return (
        <Drawer anchor="bottom"
            variant="persistent"
            open={show}
            onClose={toggleControlPanel}
        >
            <div>
                {subPanels[value]()}
                <BottomNavigation value={value} onChange={handleChange}>
                    <BottomNavigationAction value="progress" icon={<CodeRoundedIcon />} />
                    <BottomNavigationAction value="brightness" icon={<Brightness7RoundedIcon />} />
                    <BottomNavigationAction value="font" icon={<TranslateRoundedIcon />} />
                    <BottomNavigationAction value="read" icon={<MenuBookRoundedIcon />} />
                    <BottomNavigationAction value="bookMark" icon={<BookRoundedIcon />} />
                </BottomNavigation>
            </div>
        </Drawer>
    )

}
