<?php

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $admin = new \App\User([
            'name' => 'Admin',
            'email' => 'admin@email.com',
            'password' => bcrypt('admin'),
        ]);
        $admin->assignRole('admin')->save();

        DB::table('users')->insert([
            'name' => 'Simple User',
            'email' => 'simple_user@email.com',
            'password' => bcrypt('simple_user'),
        ]);
    }
}
