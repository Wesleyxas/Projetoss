package Controller;

import Service.PedidoService;
import model.Pedido;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pedidos")
public class PedidoController {

    @Autowired
    private PedidoService pedidoService;

    @PostMapping
    public Pedido salvar( int idCliente, List<Long> idProduto) {
        return pedidoService.salvar(idCliente, idProduto);
    }

    @GetMapping("/cliente/{idCliente}")
    public List<Pedido> listarPorCliente( Long idCliente) {
        return pedidoService.listarPorCliente(idCliente);
    }

    @GetMapping("/produto/{idProduto}")
    public List<Pedido> listarPorProduto( Long idProduto) {
        return pedidoService.listarPorProduto(idProduto);
    }
}

