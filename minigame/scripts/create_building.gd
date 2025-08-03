extends TileMapLayer

func create_drill_at(posInGrid:Vector2i):
	set_cell(posInGrid, 2, Vector2i(0,0))
