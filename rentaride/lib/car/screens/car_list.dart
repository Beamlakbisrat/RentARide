import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentaride/car/bloc/bloc.dart';
import 'package:rentaride/car/car.dart';
import 'package:rentaride/car/screens/car_add_update.dart';

class CarList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Car'),
      ),
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarOperationFailure) {
            return Text('Could not do car operation');
          }

          if (state is CarLoadSuccess) {
            final cars = state.cars;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, idx) => ListTile(
                title: Text('${cars[idx].brand}'),
                subtitle: Text('${cars[idx].model}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(CarDetail.routeName, arguments: cars[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateCar.routeName,
          arguments: CarArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
