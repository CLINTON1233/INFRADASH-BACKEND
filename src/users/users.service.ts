import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private usersRepository: Repository<User>,
  ) {}

  async create(userData: Partial<User>): Promise<User> {
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const user = this.usersRepository.create({ ...userData, password: hashedPassword });
    return this.usersRepository.save(user);
  }
async findByEmail(email: string): Promise<User | undefined> {
  const user = await this.usersRepository.findOne({ where: { email } });
  return user ?? undefined;
}
}
