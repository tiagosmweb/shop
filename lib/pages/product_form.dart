// ignore_for_file: sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
    print(newProduct.id);
    print(newProduct.price);
    print(newProduct.name);
    print(newProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Url da imagem'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
