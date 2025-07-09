export type Item = {
  _internal_id: string; // Svelte key用のユニークID
  id: string; // Svelteのkeyとして使用するユニークID
  item_id: string;
  item_label: string;
  db_column_name: string;
  data_type: 'string' | 'number' | 'checkbox';
  length: number | null;
  is_list_display: boolean;
  is_detail_display: boolean;
  is_search_filter: boolean;
  sort_key: number;
};

export type View = {
  id: string; // Svelteのkeyとして使用するユニークID
  view_id: string;
  parent_view_id: string;
  content_title: string;
  url: string;
  sort_key: number | null;
  layout_key: string;
  items: Item[];
};
