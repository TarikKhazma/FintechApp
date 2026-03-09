import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import { SignupDto } from './dto/signup.dto';
import { SigninDto } from './dto/signin.dto';
export interface AuthResponse {
    token: string;
    email: string;
}
export declare class AuthService {
    private readonly users;
    private readonly jwt;
    constructor(users: UsersService, jwt: JwtService);
    signup(dto: SignupDto): Promise<AuthResponse>;
    signin(dto: SigninDto): Promise<AuthResponse>;
}
