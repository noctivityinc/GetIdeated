require 'test_helper'

class VersionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Version.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Version.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Version.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to version_url(assigns(:version))
  end

  def test_edit
    get :edit, :id => Version.first
    assert_template 'edit'
  end

  def test_update_invalid
    Version.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Version.first
    assert_template 'edit'
  end

  def test_update_valid
    Version.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Version.first
    assert_redirected_to version_url(assigns(:version))
  end

  def test_destroy
    version = Version.first
    delete :destroy, :id => version
    assert_redirected_to versions_url
    assert !Version.exists?(version.id)
  end
end
