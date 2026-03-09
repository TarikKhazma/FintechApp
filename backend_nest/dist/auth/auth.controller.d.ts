import { AuthService } from './auth.service';
import { SignupDto } from './dto/signup.dto';
import { SigninDto } from './dto/signin.dto';
export declare class AuthController {
    private readonly authService;
    constructor(authService: AuthService);
    signup(dto: SignupDto): Promise<import("./auth.service").AuthResponse>;
    signin(dto: SigninDto): Promise<import("./auth.service").AuthResponse>;
}
