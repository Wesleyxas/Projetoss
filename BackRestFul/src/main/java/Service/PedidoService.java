package Service;

import model.Pedido;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repositorio.PedidoRepository;

import java.util.List;

@Service
public class PedidoService {

    @Autowired
    private PedidoRepository pedidoRepository;

    private ClienteService clienteService;

    private ProdutoService produtoService;

    public Pedido salvar(int IdCliente, List<Long> IdProduto){
        Pedido p = new Pedido();
        p.setIdCliente(IdCliente);
        p.setIdsProdutos(IdProduto);

        return pedidoRepository.save(p);
    }

    public List<Pedido> listarPorCliente(Long idCliente) {
        return pedidoRepository.findByIdCliente(idCliente);
    }

    public List<Pedido> listarPorProduto(Long idProduto) {
        return pedidoRepository.findByIdProdutos(idProduto);
    }




}