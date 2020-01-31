export type LanguageCode = 'en' | 'zh-cn';
export interface BookMeta {
  title: string;
  author: string;
  cover?: string;
  size: number;
  category?: string;
  language: LanguageCode;
  latestChapter?: string;
}

export type BookCatalog = Array<Chapter>;

export interface Chapter {
  title: string;
  position: number;
}

export interface Book {
  meta: BookMeta;
  path: string;
  latestPosition: number;
  catalog: BookCatalog;
  summary: string;
}
