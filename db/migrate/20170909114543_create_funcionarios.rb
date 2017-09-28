class CreateFuncionarios < ActiveRecord::Migration[5.0]
  def change
    create_table :funcionarios do |t|
      t.text :nome
      t.text :cpf

      t.timestamps
    end
    add_index :funcionarios, :cpf, unique: true
  end
end
