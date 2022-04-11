
package accesodatos;


public interface ICrud4<T> extends ICrud{
    
    void insertar(T objeto);
    
    void eliminar(int id);
    
}
