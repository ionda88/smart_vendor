import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListarCategoriasPage extends StatefulWidget {
  const ListarCategoriasPage({Key? key})
      : super(key: key);

  @override
  _ListarCategoriasState createState() => _ListarCategoriasState();
}

class _ListarCategoriasState extends State<ListarCategoriasPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Cadastro de Categorias"),
      ),
      body: Column(children: <Widget>[
        // FutureBuilder(
        //     future: listaProdutos,
        //     builder:
        //         (context, AsyncSnapshot<List<ProdutoFormacaoPreco>> snapshot) {
        //       if (snapshot.hasData) {
        //         return Expanded(
        //           child: LazyLoadScrollView(
        //             onEndOfPage: () {
        //               endOfPage();
        //             },
        //             scrollOffset: 5000,
        //             child: ListView.builder(
        //                 controller: _scrollController,
        //                 shrinkWrap: true,
        //                 itemCount: snapshot.data!.length,
        //                 itemBuilder: (context, index) {
        //                   final produto = snapshot.data![index];
        //                   return sliderProduto(produto);
        //                 }),
        //           ),
        //         );
        //       } else {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //     }),
      ]),
    );
  }
}