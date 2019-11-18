<?php

use Illuminate\Database\Seeder;

class CategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $res = new \App\Category([
            'title' => 'IT',
            'seo_description' => 'Information technology (IT) is the use of computers to store, retrieve, transmit...'
        ]);
        $res->save();
        DB::table('categories')->insert([
            ['title' => 'Programming', 'parent_id' => $res->id],
            ['title' => 'DataBase', 'parent_id' => $res->id],
            ['title' => 'DevOps', 'parent_id' => $res->id],
        ]);

        $res = new \App\Category([
            'title' => 'Business',
            'seo_description' => 'Business is the activity of making one\'s living or making money ...'
        ]);
        $res->save();
        DB::table('categories')->insert([
            ['title' => 'StartUp', 'parent_id' => $res->id],
            ['title' => 'Economics', 'parent_id' => $res->id],
            ['title' => 'Markets', 'parent_id' => $res->id],
        ]);
    }
}
