import { IsEmail, IsString } from 'class-validator';

export class SigninDto {
  @IsEmail({}, { message: 'Invalid email address' })
  email: string;

  @IsString()
  password: string;
}
