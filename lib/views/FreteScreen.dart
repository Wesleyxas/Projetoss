import 'package:flutter/material.dart';
import '../controller/frete_controller.dart';
import '../model/frete_response.dart';


class FreteScreen extends StatefulWidget {
  @override
  _FreteScreenState createState() => _FreteScreenState();
}

class _FreteScreenState extends State<FreteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cepOrigemController = TextEditingController();
  final _cepDestinoController = TextEditingController();
  final _pesoController = TextEditingController();
  final _comprimentoController = TextEditingController();
  final _larguraController = TextEditingController();
  final _alturaController = TextEditingController();
  final _freteController = FreteController();
  List<FreteResponse> _fretes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Frete'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField('CEP Origem', _cepOrigemController),
              _buildTextField('CEP Destino', _cepDestinoController),
              _buildTextField('Peso (kg)', _pesoController, keyboardType: TextInputType.number),
              _buildTextField('Comprimento (cm)', _comprimentoController, keyboardType: TextInputType.number),
              _buildTextField('Largura (cm)', _larguraController, keyboardType: TextInputType.number),
              _buildTextField('Altura (cm)', _alturaController, keyboardType: TextInputType.number),
              SizedBox(height: 20),
              _buildCalculateButton(),
              if (_errorMessage.isNotEmpty) _buildErrorMessage(),
              if (_isLoading) _buildLoadingIndicator(),
              if (_fretes.isNotEmpty) _buildResultsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      keyboardType: keyboardType,
      validator: (value) => value == null || value.isEmpty ? 'Informe $label' : null,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _calcularFrete,
      child: Text('Calcular Frete', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(vertical: 16)),
    );
  }

  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildResultsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _fretes.length,
        itemBuilder: (context, index) {
          final frete = _fretes[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(frete.servico, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Valor: R\$ ${frete.valor.toStringAsFixed(2)} - Prazo: ${frete.prazo} dias'),
            ),
          );
        },
      ),
    );
  }

  Future<void> _calcularFrete() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _fretes.clear();
      });
      try {
        _fretes = await _freteController.calcularFrete(
          _cepOrigemController.text,
          _cepDestinoController.text,
          _pesoController.text,
          _comprimentoController.text,
          _larguraController.text,
          _alturaController.text,
        );
      } catch (e) {
        _errorMessage = 'Erro: ${e.toString()}';
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}