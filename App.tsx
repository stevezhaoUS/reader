import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { NavigationContainer } from '@react-navigation/native';
import React from 'react';
import { Button, SafeAreaView, StyleSheet, Text } from 'react-native';
import 'react-native-gesture-handler';
import Library from './components/LIbrary';
import Shelf from './components/Shelf';


export default function App() {
  const Tab = createBottomTabNavigator();
  return (
      <NavigationContainer>
        <Tab.Navigator>
          <Tab.Screen name="Shelf" component={Shelf} />
          <Tab.Screen name="Library" component={Library} />
        </Tab.Navigator>
      </NavigationContainer>
  );
}
