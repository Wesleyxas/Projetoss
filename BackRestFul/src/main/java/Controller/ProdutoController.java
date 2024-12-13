package Controller;

import Service.ProdutoService;
import model.Produto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/produtos")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @PostMapping
    public Produto salvar( Produto produto) {
        return produtoService.salvar(produto);
    }

    @GetMapping
    public List<Produto> listarTodos() {
        return produtoService.listarTodos();
    }

    @GetMapping("/{id}")
    public Produto buscarPorId( Long id) {
        return produtoService.buscarPorId(id);
    }

    @GetMapping("/nome/{nome}")
    public Optional<Produto> listarPorNome( String nome) {
        return produtoService.buscarPorNome(nome);
    }
}

