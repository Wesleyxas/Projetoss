package repositorio;

import model.Pedido;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PedidoRepository extends JpaRepository<Pedido, Long> {
    List<Pedido> findByIdCliente(Long IdCliente);
    List<Pedido> findByIdProdutos(Long IdProduto);
}
