# flutter_cell

A dynamic widget demo.

## Example

This example widget is built on [flutter_hooks](https://github.com/rrousselGit/flutter_hooks)

```dart
class Example extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    Map events = {
      'increment': () {
        counter.value++;
      },
      'decrement': () {
        counter.value--;
      },
    };

    Map slots = {
      'double': DoubleWidget(count: counter.value)
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Cell(
        template: '''
          <Center>
            <Column alignment="center">
              <Text>You have pushed the button this many times:</Text>
              <Text>${counter.value}</Text>
              <Slot name="double"></Slot>
            </Column>
          </Center>
        ''',
        slots: slots
      ),
      floatingActionButton: Cell(
        template: '''
          <Column alignment="end" crossAlignment="end">
            <Padding padding="0, 5, 0, 5">
              <FloatingActionButton tooltip="Increment" onPressed="increment">
                <Icon type="add"></Icon>
              </FloatingActionButton>
            </Padding>
            <Padding padding="0, 5, 0, 5">
              <FloatingActionButton tooltip="Decrement" onPressed="decrement">
                <Icon type="remove"></Icon>
              </FloatingActionButton>
            </Padding>
          </Column>
        ''',
        events: events
      )
    );
  }
}
```

## Note

flutter_cell is immature, only for learning.