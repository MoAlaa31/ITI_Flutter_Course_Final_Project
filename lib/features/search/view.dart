import 'package:final_project/cores/resources/app_colors.dart';
import 'package:final_project/features/Detailed/view.dart';
import 'package:final_project/features/search/search_cubit.dart';
import 'package:final_project/features/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        // leading: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        // leadingWidth: 54,
        title: Expanded(
          child: TextFormField(
            controller: cubit.searchController,
            onFieldSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                cubit.getSearchResults(value);
              }
            },
            focusNode: _focusNode,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Icon(
                  Icons.search_rounded,
                  color: Color(0xff7C7979),
                  size: 30,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.searchController.clear();
                  FocusScope.of(context).unfocus();
                },
                icon: Container(
                  width: 18.33,
                  height: 18.33,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              fillColor: Color(0xffF8F7F7),
              hintText: "Search here",
              hintStyle: TextStyle(
                color: AppColors.subColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.all(15),
            ),
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(
              child: Lottie.asset("assets/json/splash_loading.json"),
            );
          }
          if (state is SearchFailure) {
            return Container(child: Text(state.errMsg));
          }
          if (state is SearchSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Results for ",
                              style: TextStyle(
                                color: Color(0xff817F7F),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "“ ${cubit.searchController.text} “",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${state.model.length} Results Found",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.model.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailedPage(
                                    model: state.model[index],
                                  );
                                },
                              ),
                            );
                          },
                          child: ProductItem(
                            model: state.model[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
