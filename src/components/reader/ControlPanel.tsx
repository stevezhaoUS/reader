import { BottomNavigation, BottomNavigationAction, Drawer, IconButton, List, ListItem, Slider } from '@material-ui/core';
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
import { BookMark } from './subPanels/BookMark';
import { Brightness } from './subPanels/Brightness';
import { Font } from './subPanels/Font';
import { Read } from './subPanels/Read';

const useStyles = makeStyles({
    paperAnchorBottom: {
        top: 0
    },
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



export const ControlPanel = () => {
    const show = useSelector((state: AppState) => state.Reader.showControlPanel);
    const dispatch = useDispatch()

    const onCloseControlPanel = () => {

    }


    const [value, setValue] = React.useState('progress')

    const handleChange = (_: any, newValue: React.SetStateAction<string>) => {
        setValue(newValue)
    }

    const subPanels: { [index: string]: React.FC} = {
        progress: Progress,
        brightness: Brightness,
        font: Font,
        read: Read,
        bookMark: BookMark
    }

    const SubPanel: React.FC = subPanels[value];

    const classes = useStyles();

    return (
        <Drawer anchor="bottom"
            variant="persistent"
            open={show}
            onClose={onCloseControlPanel}
            classes={value === 'bookMark' ? {...classes} : {}}
        >
            <div>
                <SubPanel />
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
