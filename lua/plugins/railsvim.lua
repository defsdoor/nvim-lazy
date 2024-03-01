return {
  "tpope/vim-rails",
  config = function()
    vim.g.rails_projections = {
         ["app/decorators/*_decorator.rb"] = {
           command = "decorator",
           template = "class %SDecorator < SimpleDelegator\nend",
           test = {
             "test/unit/%s_decorator_test.rb",
             "spec/decorators/%s_decorator_spec.rb"
           },
           affinity = "controller"
         },
         ["app/presenters/*_presenter.rb"] = {
           command = "presenter",
           template = "class %Spresenter < BasePresenter\nend",
           test = {
             "test/unit/%s_presenter_test.rb",
             "spec/presenters/%s_presenters_spec.rb"
           },
           affinity = "model"
         },
         ["app/javascript/controllers/*_controller.js"] = {
           command = "jcontroller",
           template = "import { Controller } from \"@hotwired/stimulus\"\n\nexport default class extends Controller {\n\n}",
           affinity = "controller"
          }
        }
  end
}
