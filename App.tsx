import { NavigationContainer } from '@react-navigation/native';
import React from 'react';
import { ActivityIndicator, SafeAreaView, StyleSheet, Text, Button } from 'react-native';
import 'react-native-gesture-handler';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';


export default function App() {
  const Tab = createBottomTabNavigator();
  return (
    <NavigationContainer>
    <Tab.Navigator>
      <Tab.Screen name="Empty" component={empty} />  
      <Tab.Screen name="Example" component={example} />  
    </Tab.Navigator>
    

    </NavigationContainer>
  );
}

const empty = ({navigation}) => (
  <Button title="go" 
  onPress={() => navigation.navigate('example', {name: 'Jane'})}
  />
)

const example = ({navigation}) => (
  <SafeAreaView style={styles.container}>
    <Text> Bingo !!!</Text>
    <Text>Hello</Text>

  <Button title="go" 
  onPress={() => navigation.navigate('empty', {name: 'Jane'})}
  />
  </SafeAreaView>
)

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f2020f',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
