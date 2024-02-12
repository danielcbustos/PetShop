package com.petshop.backend.security.authentication;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.petshop.backend.entities.Pet;
import com.petshop.backend.entities.User;
import com.petshop.backend.enums.Role;
import com.petshop.backend.repositories.contracts.IUserRepository;
import com.petshop.backend.security.jwt.JwtService;
import com.petshop.backend.security.request.LoginRequest;
import com.petshop.backend.security.request.RegisterRequest;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

        @Autowired
        private final IUserRepository userRepository;
        private final JwtService jwtService;
        private final PasswordEncoder passwordEncoder;
        private final AuthenticationManager authenticationManager;

        public AuthResponse login(LoginRequest request) {
                authenticationManager
                                .authenticate(new UsernamePasswordAuthenticationToken(request.getUsername(),
                                                request.getPassword()));
                UserDetails user = userRepository.findByUsername(request.getUsername())
                                .orElseThrow(() -> new UsernameNotFoundException("Username not found "));
                String token = jwtService.getToken(user);
                return AuthResponse.builder()
                                .token(token)
                                .build();

        }

        public AuthResponse register(RegisterRequest request) {

                User user = User.builder()
                                .username(request.getUsername())
                                .password(passwordEncoder.encode(request.getPassword()))
                                .firstname(request.getFirstname())
                                .lastname(request.getLastname())
                                .email(request.getEmail())
                                .role(Role.CLIENT)
                                .build();

                // List<Pet> pets = request.getPets();
                // for (Pet pet : pets) {
                // pet.setUser(user);
                // }
                // user.setPets(pets);
                userRepository.save(user);

                return AuthResponse.builder()
                                .token(jwtService.getToken(user))
                                .build();

        }

        public UserDetails getCurrentUserDetails() {
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                if (authentication != null && authentication.isAuthenticated()
                                && authentication.getPrincipal() instanceof UserDetails) {
                        return (UserDetails) authentication.getPrincipal();
                }
                return null;
        }

        public User getCurrentUser() {
                UserDetails userDetails = getCurrentUserDetails();
                if (userDetails != null && userDetails instanceof User) {
                        return (User) userDetails;
                }
                return null;
        }

}