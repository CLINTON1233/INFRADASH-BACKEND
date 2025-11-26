import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { user } from './user.entity';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(user)
    private usersRepository: Repository<user>,
  ) {}

  // Find all users
  async findAll(): Promise<user[]> {
    return this.usersRepository.find({
      order: {
        created_at: 'DESC'
      }
    });
  }

  // Create new user
  async create(userData: Partial<user>): Promise<user> {
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const user = this.usersRepository.create({
      ...userData,
      password: hashedPassword,
    });
    return this.usersRepository.save(user);
  }

  // Update user
  async update(id: number, updateData: Partial<user>): Promise<user> {
    // Jika ada password baru, hash password
    if (updateData.password) {
      updateData.password = await bcrypt.hash(updateData.password, 10);
    }
    
    await this.usersRepository.update(id, updateData);
    return (await this.usersRepository.findOne({ where: { id } }))!;
  }

  // Delete user
  async delete(id: number): Promise<void> {
    await this.usersRepository.delete(id);
  }

  async findByEmail(email: string): Promise<user | undefined> {
    const user = await this.usersRepository.findOne({ where: { email } });
    return user ?? undefined;
  }

  // Find user by ID
  async findById(id: number): Promise<user | undefined> {
    const user = await this.usersRepository.findOne({ where: { id } });
    return user ?? undefined;
  }
// For authentication purposes
   async findByEmailForAuth(email: string): Promise<user | undefined> {
    return this.findByEmail(email);
  }
}