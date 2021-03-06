package bg.softuni.gamestore.repositories;

import bg.softuni.gamestore.models.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.Set;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmailAndPassword(String email, String password);

    Set<User> findAllByLoggedInIsTrue();
}
