<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    public $timestamps = false;

    protected $fillable = ['title', 'icon', 'seo_description', 'parent_id'];

    public function parent()
    {
        return $this->belongsTo(Category::class, 'id');
    }

    /*public function subcategories()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }*/
}
