import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_do_it/controller/search/search_bloc.dart';
import 'package:just_do_it/screens/search.dart';
import 'package:just_do_it/utilities/colors.dart';
import 'package:just_do_it/widgets/searchFunction.dart';

class SearchInputField extends StatelessWidget {


   const SearchInputField({super.key});

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(InitialSearch());
    });
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return TextFormField(
          autofocus: true,
          controller: searchController,
          cursorColor: Grey(),
          style: TextStyle(color: Grey()),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Grey(),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Grey(),
              ),
              onPressed: () => clearText(),
            ),
            filled: true,
            fillColor: ThemeGrey(),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
            hintText: 'search . . .',
            hintStyle: TextStyle(
              color: Grey(),
            ),
          ),
          onChanged: (value) {
            // searchTask(value, newDateTime,context);
            BlocProvider.of<SearchBloc>(context).add(UpdateSearch(val: value));
            
            // state.value = value;
          },
        );
      },
    );
  }

  void clearText() {
    searchController.clear();
  }
}
