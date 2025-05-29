import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoadingWrapper<T> extends StatefulWidget {
  final Future<T> Function() future; // Veri getiren fonksiyon
  final Widget Function(T data)
      builder; // Başarılı veri geldikten sonra gösterilecek widget

  const LoadingWrapper({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  State<LoadingWrapper<T>> createState() => _LoadingWrapperState<T>();
}

class _LoadingWrapperState<T> extends State<LoadingWrapper<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future(); // İlk veri yükleme işlemi
  }

  void _retry() {
    setState(() {
      _future = widget.future(); // Hata olursa veriyi tekrar yükle
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Yükleniyor animasyonu
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).ErrorOccurred), // Hata mesajı
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _retry, // Tekrar dene
                  child: Text("Tekrar Dene"),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          return widget.builder(
              snapshot.data as T); // Başarılı veri geldiyse builder ile göster
        } else {
          return Center(
              child: Text(S.of(context).DataNotFound)); // Veri yoksa mesaj
        }
      },
    );
  }
}
