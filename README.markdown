AccessControl
=============
**Warning: this is a beta plugin!**

AccessControl is a user authorization plugin. It gives you a role based permission system without having to do any work. There are users and roles, each have permission.
A user can play any role and inherit permissions through that role. A user may also have individual permissions. For example, you can create a role to update
the news section on your site and give a user that role. You may also give him permission to update contact information. Combining these two functionalities gives you 
a rich permission system inside your application.

Features
---------
* Role Based
* Easy to query permission (example: @current_user.can_manage_news?)
* God permission
* Easy to use


Up and Running
================

Install
-------

First, prepare your application. AccessControl does not create user logins, it soley is a permission system. I'm assuming you have model named user. AccessControl
also uses two other models: Permission & Role. Once your users can login and log out, you are ready to use AccessControl.

1. Install
		./script/plugin install git://github.com/Adman65/AccessControl.git

2. Prepare the database
		./script/generate access_control models
		rake db:migrate

Step 2 creates a migration that creates one join table, role, and permission table. Migrate your database and you are ready to start working with permissions.


Working with Permissions
-------

Each permission you need in your application is a column in the permission model. Once again, we use a migration to create our permission. 
		./script/generate access_control permission NameOfYourPermission
		./script/generate access_control permission YourFirstPermission YourSecondPermission YourThirdPermission
		
The first creates a named migration. As you can see from the second example you can also create multiple permissions at once. Now, install your permissions:
		rake db:migrate
		
You're permissions are now ready. They can be attached to a user or a role. Now, you need to tell your user model that is has access controls:
		class User < ActiveRecord::Base
			has_access_controls
			# some more code
		end

And that's it! You are now ready to start granting and creating your authorization structure. First, lets focus on our users. 
Let us assume that there is a permission named PostNews. In your application, permissions are passed in underscore notation so post_news is correct.
Let's give a user this permission:
		user = User.find_by_name "Adam", "Hawkins"
		user.can_post_news? 
		user.grant :post_news
		user.can_post_news?

Voilla, Adam can now post_news. But that's no good by itself. So now check aganist for the permission in the controller:
		class NewsController < ActionController::Base
			before_filter permission_required(@current_user, :post_news)
		end
		
Your controllers are protected from people who can't post news. Now lets expand our permissions by adding a role:
		editors = Role.create :name => "Editors", :description => "Manage content around the site."
		# assuming we have these permissions in the system
		editors.grant :manage_news
		editors.grant :manage_categories
		editors.grant :manage_comments
		editors.grant :ban_users
		# now we need adam to be an editor
		user.plays :editor
		user.can_manage_news? (true)
		user.can_manage_categories? (true)
		user.can_manage_comments (true)
		user.can_ban_users? (true)
		
Man, Adam sure got a lot of responsibilities, hopefully you trust him :)


Using the language
==============

Its nice to be able to express concepts in code that when you read the code, you understand what is going on. AccessControl gives you expressive method names
express authorization inside your code. The methods below can be user on a User or Role.
		@user.can_manage_news?
		@user.can? :manage_news
		@user.can? "manage_news"
		@user.has_permission :manage_news
		@user.cannot? :manage_news
		@user.grant :permission
		@user.authorize :permission
		@user.deauthorize :permission
		@user.permissions (returns an array of all the permissions a user/role has)
		
These methods only work on users
		@user.plays :role_name
		@user.plays? :role_name
		@user.is_a_editor?


Utilties
===========
Sometimes you want to see all the permissions in your application:
			rake access_control:permissions



Copyright (c) 2009 Adam Hawkins, released under the MIT license
